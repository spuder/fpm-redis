class initscript() {

  notice("Applying ${fpm_osfamily} init script")

  file {"${::fpm_installdir}/etc/init.d/redis-${::fpm_redis_port}":
      ensure => file,
    # content => "${fpm_redis_pwd}/templates/redis_init_${::osfamily}.erb",
    content => template("${fpm_redis_pwd}/templates/redis_init_${::fpm_osfamily}.erb"),
    mode    => 0755,
    owner   => 'root',
    group   => 'root',
  }

}
include initscript
