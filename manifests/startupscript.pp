class startupscript() {

  file {"${::fpm_installdir}/etc/init.d/redis_${::fpm_redis_port}":
    # content => "${fpm_redis_pwd}/templates/redis_init_${::osfamily}.erb",
    content => template("${fpm_redis_pwd}/templates/redis_init_${::osfamily}.erb"),
  }
    
}
include startupscript
