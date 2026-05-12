<?php
/**
 * Template Name: Página Principal WebFusion
 * WebFusion Digital S.L. — Tema corporativo
 */
get_header(); ?>

<main class="webfusion-main">


  <!-- Sección hero principal -->
  <section class="hero">
    <div class="hero-content">
      <!-- HEMOS CAMBIADO ESTA LÍNEA PARA EL PROYECTO -->
      <h1>Proyecto Finalizado por Sergio</h1>
      <p class="tagline">Despliegue automático con Vagrant y Docker funcionando.</p>
      <a href="#servicios" class="btn-primary">
        Descubre nuestros servicios
      </a>
    </div>
  </section>
  <!-- Sección de servicios del cliente -->
  <section id="servicios" class="services">
    <div class="container">
      <h2>Nuestros Servicios</h2>
      <?php
        $args = array(
          'post_type'      => 'servicios',
          'posts_per_page' => 6,
          'orderby'        => 'menu_order',
        );
  $servicios = new WP_Query($args);
        if ($servicios->have_posts()) :
          while ($servicios->have_posts()) :
            $servicios->the_post(); ?>
            <div class="service-card">
              <h3><?php the_title(); ?></h3>
              <?php the_excerpt(); ?>
            </div>
          <?php endwhile;
          wp_reset_postdata();
        endif; ?>
    </div>
  </section>

  <!-- Sección de contacto -->
  <section class="contact">
    <h2>Contacta con nosotros</h2>
    <?php echo do_shortcode('[contact-form-7 id="1"]'); ?>
  </section>

</main>

<?php get_footer(); ?>

