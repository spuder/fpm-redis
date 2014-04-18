class config() {

  file {"${::fpm_installdir}/etc/redis/${::fpm_redis_port}.conf":
    ensure => file,
    content => template("${::fpm_redis_pwd}/templates/config.erb"),
  }

}
include config