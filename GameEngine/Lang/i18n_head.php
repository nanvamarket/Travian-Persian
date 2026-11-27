<?php
/**
 * Shared <head> additions for every page: mobile viewport, responsive CSS
 * and, for right-to-left languages (Persian), the Vazirmatn font and RTL CSS.
 *
 * Usage inside <head>:  <?php tz_i18n_head(); ?>
 * Pages one folder deep (Admin/, notification/) pass the prefix: tz_i18n_head('../');
 *
 * $context: 'game' for in-game pages (T3 layout), 'landing' for index.php,
 *           'admin' for the admin panel.
 */

if (!function_exists('tz_is_rtl')) {
    function tz_is_rtl($language = null)
    {
        if ($language === null) {
            $language = defined('LANG') ? LANG : 'en';
        }
        return in_array($language, ['fa', 'ar', 'he', 'ur'], true);
    }
}

if (!function_exists('tz_i18n_head')) {
    function tz_i18n_head($base = '', $context = 'game')
    {
        $base = htmlspecialchars((string) $base, ENT_QUOTES);
        $lang = defined('LANG') ? preg_replace('/[^a-z_]/', '', LANG) : 'en';
        $ver  = '1';

        echo "\n\t<meta name=\"viewport\" content=\"width=device-width, initial-scale=1\" />\n";
        echo "\t<link rel=\"stylesheet\" type=\"text/css\" href=\"{$base}css/tz-responsive.css?v={$ver}\" />\n";

        if (tz_is_rtl($lang)) {
            echo "\t<link rel=\"preload\" href=\"{$base}css/fonts/vazirmatn/Vazirmatn-Regular.woff2\" as=\"font\" type=\"font/woff2\" crossorigin=\"anonymous\" />\n";
            echo "\t<link rel=\"stylesheet\" type=\"text/css\" href=\"{$base}css/tz-rtl.css?v={$ver}\" />\n";
        }

        // The pages use an old XHTML <html> tag without lang/dir. Set them here,
        // before <body> is parsed, so CSS selectors like html[dir=rtl] apply at once.
        // In-game pages keep the classic left-to-right frame (absolute-positioned
        // header, menus, village maps) and only switch the text areas to RTL in
        // css/tz-rtl.css. The landing pages are flipped as a whole.
        $rtl = tz_is_rtl($lang);
        $ctx = preg_replace('/[^a-z]/', '', (string) $context);
        $dir = ($rtl && $ctx === 'landing') ? 'rtl' : 'ltr';
        $cls = ' tz-' . $ctx . ($rtl ? ' tz-rtl' : '');
        echo "\t<script type=\"text/javascript\">(function(d){d.setAttribute('lang','{$lang}');d.setAttribute('dir','{$dir}');d.className+='{$cls}';})(document.documentElement);</script>\n";
    }
}
