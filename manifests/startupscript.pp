class startupscript() {

  file {"${fpm_installdir}/etc/init.d/redis_${::fpm_redis_port}":
    source => "${fpm_redis_pwd}/templates/redis_init_${::osfamily}.erb",
  }
    
}
include startupscript
