# frozen_string_literal: true

module Jekyll
  module GitHubMetadata
    class RepositoryFinder
      NoRepositoryError = Class.new(Jekyll::Errors::FatalException)

      attr_reader :site
      def initialize(site)
        @site = site
      end

      # Public: fetches the repository name with owner to fetch metadata for.
      # In order of precedence, this method uses:
      # 1. the environment variable $PAGES_REPO_NWO
      # 2. 'repository' variable in the site config
      # 3. the 'origin' git remote's URL
      #
      # site - the Jekyll::Site being processed
      #
      # Return the name with owner (e.g. 'parkr/my-repo') or raises an
      # error if one cannot be found.
      def nwo
        @nwo ||= begin
          nwo_from_env || \
            nwo_from_config || \
            nwo_from_git_origin_remote || \
            proc do
              raise NoRepositoryError, "No repo name found. " \
                "Specify using PAGES_REPO_NWO environment variables, " \
                "'repository' in your configuration, or set up an 'origin' " \
                "git remote pointing to your github.com repository."
            end.call
        end
      end

      private

      def nwo_from_env
        ENV["PAGES_REPO_NWO"]
      end

      def nwo_from_config
        repo = site.config["repository"]
        repo if repo && repo.is_a?(String) && repo.include?("/")
      end

      def git_exe_path
        ENV["PATH"].to_s
          .split(File::PATH_SEPARATOR)
          .map { |path| File.join(path, "git") }
          .find { |path| File.exist?(path) }
      end

      def git_remotes
        return [] if git_exe_path.nil?
        `#{git_exe_path} remote --verbose`.to_s.strip.split("\n")
      end

      def git_remote_url
        git_remotes.grep(%r!\Aorigin\t!).map do |remote|
          remote.sub(%r!\Aorigin\t(.*) \([a-z]+\)!, "\\1")
        end.uniq.first || ""
      end

      def nwo_from_git_origin_remote
        return unless Jekyll.env == "development" || Jekyll.env == "test"
        matches = git_remote_url.chomp(".git").match %r!github.com(:|/)([\w-]+)/([\w\.-]+)!
        matches[2..3].join("/") if matches
      end
    end
  end
end
