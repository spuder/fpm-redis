class fpm::packages {

    $required_packages=['rubygems','ruby-devel', 'gcc', 'gcc-c++', 'rpm-build']

	ensure_packages($required_packages)

	package { 'fpm' :
	  ensure => present,
	  provider => gem,
	}
}
include fpm::packages