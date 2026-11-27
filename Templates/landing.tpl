<?php
/*
 * Modern landing page (index.php). Original artwork in img/tz/.
 * Expects: $lang, $tzl (landing strings), $tzStats = ['total','active','online'].
 */
if (!function_exists('tzl_e')) {
    function tzl_e($s) { return htmlspecialchars((string) $s, ENT_QUOTES, 'UTF-8'); }
}
if (!function_exists('tzl_num')) {
    // Persian digits for RTL Persian pages, plain digits otherwise.
    function tzl_num($n) {
        $s = number_format((int) $n);
        if (defined('LANG') && LANG === 'fa') {
            $s = strtr($s, ['0'=>'۰','1'=>'۱','2'=>'۲','3'=>'۳','4'=>'۴','5'=>'۵','6'=>'۶','7'=>'۷','8'=>'۸','9'=>'۹', ','=>'٬']);
        }
        return $s;
    }
}
if (!function_exists('tzl_icon')) {
    // Small line icons for the feature cards.
    function tzl_icon($i) {
        $p = [
            // build: house with hammer
            '<path d="M4 15 L14 6 L24 15"/><path d="M7 13 V26 H21 V13"/><path d="M12 26 V19 H16 V26"/><path d="M22 4 L28 10"/><path d="M25 7 L19 13"/>',
            // battle: crossed swords and shield
            '<path d="M5 5 L20 20"/><path d="M27 5 L12 20"/><path d="M17 23 L23 17"/><path d="M9 17 L15 23"/><path d="M5 5 L5 9 L8 9"/><path d="M27 5 L27 9 L24 9"/><path d="M16 22 L16 29"/>',
            // alliance: banner on a pole
            '<path d="M7 29 V4"/><path d="M7 5 H25 L21 11 L25 17 H7"/><circle cx="14" cy="11" r="2.4"/>',
            // trade: balance scale
            '<path d="M16 4 V27"/><path d="M10 27 H22"/><path d="M6 9 H26"/><path d="M6 9 L2 18 H10 Z"/><path d="M26 9 L22 18 H30 Z"/>',
        ];
        return '<svg viewBox="0 0 32 32" width="30" height="30" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">' . ($p[$i] ?? $p[0]) . '</svg>';
    }
}
$tzlName = SERVER_NAME;
?>
<a class="tzl-skip" href="#tzl-main"><?php echo tzl_e($tzl['skip']); ?></a>

<header class="tzl-bar">
	<div class="tzl-wrap tzl-bar-in">
		<a class="tzl-brand" href="index.php">
			<img src="img/tz/logo.svg" alt="" width="40" height="46" />
			<span><?php echo tzl_e($tzlName); ?></span>
		</a>
		<nav class="tzl-nav" aria-label="<?php echo tzl_e($tzl['menu']); ?>">
			<a href="tutorial.php"><?php echo TUTORIAL; ?></a>
			<a href="anleitung.php"><?php echo $lang['index'][0][2]; ?></a>
			<a href="spielregeln.php"><?php echo SPIELREGELN; ?></a>
			<a href="https://github.com/Shadowss/TravianZ/discussions" target="_blank" rel="noopener"><?php echo FORUM; ?></a>
		</nav>
		<div class="tzl-bar-cta">
			<a class="tzl-btn tzl-btn-ghost" href="login.php"><?php echo LOGIN; ?></a>
			<a class="tzl-btn tzl-btn-gold" href="anmelden.php"><?php echo $lang['register']; ?></a>
		</div>
	</div>
</header>

<main id="tzl-main">
	<section class="tzl-hero">
		<div class="tzl-hero-art" role="img" aria-label="<?php echo tzl_e($tzl['art_alt']); ?>"></div>
		<div class="tzl-wrap tzl-hero-in">
			<div class="tzl-hero-copy">
				<p class="tzl-kicker"><?php echo tzl_e($tzl['kicker']); ?></p>
				<h1><?php echo tzl_e($tzl['title']); ?></h1>
				<p class="tzl-lead"><?php echo tzl_e($tzl['lead']); ?></p>
				<div class="tzl-hero-cta">
					<a class="tzl-btn tzl-btn-gold tzl-btn-lg" href="anmelden.php"><?php echo tzl_e($tzl['cta']); ?></a>
					<a class="tzl-btn tzl-btn-light tzl-btn-lg" href="login.php"><?php echo tzl_e($tzl['have_account']); ?></a>
				</div>
				<dl class="tzl-stats">
					<div><dt><?php echo $lang['index'][0][7]; ?></dt><dd><?php echo tzl_num($tzStats['total']); ?></dd></div>
					<div><dt><?php echo $lang['index'][0][8]; ?></dt><dd><?php echo tzl_num($tzStats['active']); ?></dd></div>
					<div><dt><?php echo $lang['index'][0][9]; ?></dt><dd><span class="tzl-dot" aria-hidden="true"></span><?php echo tzl_num($tzStats['online']); ?></dd></div>
				</dl>
			</div>
		</div>
	</section>

	<section class="tzl-section tzl-about">
		<div class="tzl-wrap">
			<div class="tzl-head">
				<h2><?php echo $lang['index'][0][4]; ?></h2>
				<div class="tzl-intro"><p><?php echo $lang['index'][0][5]; ?></p></div>
			</div>
			<div class="tzl-cards">
				<?php foreach ($tzl['features'] as $i => $f) { ?>
				<article class="tzl-card">
					<span class="tzl-ico tzl-ico-<?php echo (int) $i; ?>" aria-hidden="true"><?php echo tzl_icon($i); ?></span>
					<h3><?php echo tzl_e($f[0]); ?></h3>
					<p><?php echo tzl_e($f[1]); ?></p>
				</article>
				<?php } ?>
			</div>
		</div>
	</section>

	<section class="tzl-section tzl-start">
		<div class="tzl-wrap tzl-split">
			<div>
				<h2><?php echo tzl_e($tzl['steps_title']); ?></h2>
				<ol class="tzl-steps">
					<?php foreach ($tzl['steps'] as $i => $s) { ?>
					<li>
						<span class="tzl-step-n"><?php echo tzl_num($i + 1); ?></span>
						<div><h3><?php echo tzl_e($s[0]); ?></h3><p><?php echo tzl_e($s[1]); ?></p></div>
					</li>
					<?php } ?>
				</ol>
				<a class="tzl-btn tzl-btn-green" href="anmelden.php"><?php echo tzl_e($tzl['cta']); ?></a>
			</div>
			<aside class="tzl-news">
				<h2><?php echo NEWS; ?></h2>
				<div class="tzl-news-body"><?php include __DIR__ . '/indexnews.tpl'; ?></div>
			</aside>
		</div>
	</section>

	<section class="tzl-final">
		<div class="tzl-wrap">
			<h2><?php echo tzl_e($tzl['final_title']); ?></h2>
			<p><?php echo tzl_e($tzl['final_text']); ?></p>
			<a class="tzl-btn tzl-btn-gold tzl-btn-lg" href="anmelden.php"><?php echo $lang['register']; ?></a>
		</div>
	</section>
</main>

<footer class="tzl-foot">
	<div class="tzl-wrap tzl-foot-in">
		<a class="tzl-brand tzl-brand-sm" href="index.php">
			<img src="img/tz/logo.svg" alt="" width="28" height="32" />
			<span><?php echo tzl_e($tzlName); ?></span>
		</a>
		<nav class="tzl-foot-nav">
			<a href="anleitung.php?s=3"><?php echo FAQ; ?></a>
			<a href="spielregeln.php"><?php echo SPIELREGELN; ?></a>
			<a href="agb.php"><?php echo AGB; ?></a>
			<a href="impressum.php"><?php echo IMPRINT; ?></a>
			<a href="tutorial.php"><?php echo TUTORIAL; ?></a>
		</nav>
		<p class="tzl-copy">&copy; <?php echo date('Y'); ?> <?php echo tzl_e($tzlName); ?> &middot; Powered by TravianZ</p>
	</div>
</footer>
