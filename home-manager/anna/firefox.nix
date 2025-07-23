{ config, pkgs, ...}:
{
  programs.firefox = {
      enable = true;

      profiles.anna = {
        isDefault = true;
        # extensions =  {
        #   "TamperMonkey"
        # };

        # SETTINGS ARE READ FROM .mozilla/firefox/user/prefs.js
        # then set in whatever homemanger writes to .mozilla/firefox/user/user.js
        # go to about:config in URL to see
        settings = { # helping myself get fingerprinted
          "browser.startup.homepage" = "https://search.nixos.org/options|https://home-manager-options.extranix.com/|https://nix-community.github.io/home-manager/options.xhtml|https://github.com/supergohappysmile|https://vault.bitwarden.com/#/login";
          # below clears data on close
          # steal from this
          # https://github.com/yokoffing/Betterfox/blob/main/Securefox.js 
          # https://github.com/yokoffing/Betterfox/wiki/Optional-Hardening
          "privacy.clearOnShutdown.cache" = true;
          "privacy.clearOnShutdown.cookies" = true;
          "privacy.clearOnShutdown.downloads" = true;
          "privacy.clearOnShutdown.formdata" = true;
          "privacy.clearOnShutdown.history" = true;
          "privacy.clearOnShutdown.offlineApps" = true;
          "privacy.clearOnShutdown.openWindows" = true;
          "privacy.clearOnShutdown.sessions" = true;
          "privacy.clearOnShutdown.siteSettings" = true;
          "privacy.clearOnShutdown_v2.browsingHistoryAndDownloads" = true;
          "privacy.clearOnShutdown_v2.cache" = true;
          "privacy.clearOnShutdown_v2.cookiesAndStorage" = true;
          "privacy.clearOnShutdown_v2.formdata" = true;
          "privacy.clearOnShutdown_v2.historyFormDataAndDownloads" = true;
          "privacy.clearOnShutdown_v2.siteSettings" = true;
          "privacy.sanitize.clearOnShutdown.hasMigratedToNewPrefs2" = true;
          "privacy.sanitize.clearOnShutdown.hasMigratedToNewPrefs3" = true;
          "privacy.sanitize.sanitizeOnShutdown" = true;

          "browser.sessionstore.privacy_level" = 2;
          
          
          # PREF: enable HTTPS-Only Mode
          # Warn me before loading sites that don't support HTTPS
          # in both Normal and Private Browsing windows.
          "dom.security.https_only_mode" = true;
          "dom.security.https_only_mode_error_page_user_suggestions" = true;

          # PREF: disable login manager
          "signon.rememberSignons" = false;

          # PREF: disable address and credit card manager
          "extensions.formautofill.addresses.enabled" = false;
          "extensions.formautofill.creditCards.enabled" = false;

            # PREF: disable Firefox Sync
            "identity.fxaccounts.enabled" = false;

            # PREF: disable the Firefox View tour from popping up
            "browser.firefox-view.feature-tour" = "{\"screen\":\"\",\"complete\":true}";

            # PREF: ask where to save every file
            "browser.download.useDownloadDir" = false;

          # theme
          "extensions.activeThemeID" = "{9b84b6b4-07c4-4b4b-ba21-394d86f6e9ee}";

          #https://github.com/yokoffing/Betterfox/blob/main/Smoothfox.js
          #  * OPTION: INSTANT SCROLLING (SIMPLE ADJUSTMENT)                                       *
          # recommended for 60hz+ displays
          "apz.overscroll.enabled" = true; # DEFAULT NON-LINUX
          "general.smoothScroll" = true; # DEFAULT
          "mousewheel.default.delta_multiplier_y" =  275; # 250-400; adjust this number to your liking
          # Firefox Nightly only:
          # [1] https://bugzilla.mozilla.org/show_bug.cgi?id=1846935
          "general.smoothScroll.msdPhysics.enabled" =  false; # [FF122+ Nightly]
        };
        search.force = true; # rm whatever config is already there
        search.default = "DuckDuckGo";
        search.engines = {
          "Nix Packages" = {
            urls = [{
              template = "https://search.nixos.org/packages";
              params = [
                { name = "type"; value = "packages"; }
                { name = "query"; value = "{searchTerms}"; }
              ];
            }];
            icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
            definedAliases = [ ":np" ];
          };
          "Nix Options" = {
            urls = [{
              template = "https://search.nixos.org/options";
              params = [
                { name = "type"; value = "packages"; }
                { name = "query"; value = "{searchTerms}"; }
              ];
            }];

            icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
            definedAliases = [ ":no" ];
          };

          "NixOS Wiki" = {
            urls = [{ template = "https://wiki.nixos.org/index.php?search={searchTerms}"; }];
            iconUpdateURL = "https://wiki.nixos.org/favicon.png";
            updateInterval = 24 * 60 * 60 * 1000; # every day
            definedAliases = [ ":w" ];
          };

          "YouTube" = {
            urls = [{ template = "https://www.youtube.com/results?search_query={searchTerms}"; }];
            icon = "https://www.youtube.com/favicon.ico";
            definedAliases = [ ":yt" ];
          };
          "GitHub Code" = {
            urls = [{ template = "https://github.com/search?q={searchTerms}&type=code"; }];
            icon = "https://github.githubassets.com/favicons/favicon.png";
            definedAliases = [ ":gh" ];
          };

          "Bing".metaData.hidden = true;
          "Google".metaData.alias = ":g"; # builtin engines only support specifying one additional alias
        };
      };

  };

}

