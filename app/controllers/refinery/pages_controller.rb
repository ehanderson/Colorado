module Refinery
  class PagesController < ::ApplicationController
    before_filter :find_page, :set_canonical, :except => [:preview]
    before_filter :find_page_for_preview, :only => [:preview]
    before_filter :find_footer

    # Save whole Page after delivery
    after_filter { |c| c.write_cache? }

    # This action is usually accessed with the root path, normally '/'
    def home
      render_with_templates?
      background_image
      @facebook = Refinery::SocialMediaPosts::SocialMediaPost.facebook.limit(5)
      @twitter  = Refinery::SocialMediaPosts::SocialMediaPost.twitter.limit(5)
    end
    def show
      background_image
      if current_user_can_view_page?
        if should_skip_to_first_child?
          redirect_to refinery.url_for(first_live_child.url)
        elsif page.link_url.present?
          redirect_to page.link_url
        else
          if requested_friendly_id != page.friendly_id
            redirect_to refinery.url_for(page.url), :status => 301
          else
            render_with_templates?
          end
        end
      else
        error_404
      end
      parent
    end

    def preview
      render_with_templates?(:action => :show)
    end

  protected
    def parent
      @parent = Refinery::Page.find_by_id(@page.parent_id)
    end

    def background_image
      @background_image = set_background_image
    end

    def set_background_image
      !page.images.empty? ? page.images.last.thumbnail.url : '/assets/desks.png'
    end

    def requested_friendly_id
      "#{params[:path]}/#{params[:id]}".split('/').last
    end

    def should_skip_to_first_child?
      page.skip_to_first_child && first_live_child
    end

    def current_user_can_view_page?
      page.live? || current_refinery_user_can_access?("refinery_pages")
    end

    def current_refinery_user_can_access?(plugin)
      refinery_user? && current_refinery_user.authorized_plugins.include?(plugin)
    end

    def first_live_child
      page.children.order('lft ASC').live.first
    end

    def find_page_for_preview
      if page(fallback_to_404 = false)
        # Preview existing pages
        @page.attributes = view_context.sanitize_hash params[:page]
      elsif params[:page]
        # Preview a non-persisted page
        @page = Page.new params[:page]
      end
    end

    def find_page(fallback_to_404 = true)
      @page ||= case action_name
                when "home"
                  Refinery::Page.where(:link_url => '/').first
                when "show", "preview"
                  Refinery::Page.find_by_path_or_id(params[:path], params[:id])
                end
      @page || (error_404 if fallback_to_404)
    end

    def find_footer
      @footer = Refinery::Page.find_by_slug('footer')
    end

    alias_method :page, :find_page

    def render_with_templates?(render_options = {})
      render render_options if render_options.any?
    end

    def render_options_for_template(page)
        render_options = {}
        template = page.link_url == "/" ? "home" : "show"
        render_options[:template] = "refinery/pages/#{page.view_template.presence || template}"

        render_options
    end

    def set_canonical
      @canonical = refinery.url_for @page.canonical if @page.present?
    end

    def write_cache?
      if Refinery::Pages.cache_pages_full && !refinery_user?
        cache_page(response.body, File.join('', 'refinery', 'cache', 'pages', request.path.sub("//", "/")).to_s)
      end
    end
  end
end
