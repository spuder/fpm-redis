class fpm::packages {

    $required_packages=['rubygems','ruby-devel', 'gcc', 'gcc-c++', 'rpm-build']

    ensure_packages($required_packages)

# There is no way to put a dependency on ensure_packages    
    # package { 'fpm' :
    #   ensure   => latest,
    #   provider => gem,
    # }
}
include fpm::packages