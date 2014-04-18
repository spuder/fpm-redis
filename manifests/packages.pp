class fpm::packages {

    $required_packages=['rubygems','ruby-devel', 'gcc','rpm-build']

	ensure_packages($required_packages)

	package { 'fpm' :
	  ensure => present,
	  provider => gem,
	}
}
include fpm::packages