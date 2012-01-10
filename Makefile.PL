use 5.008000;
use ExtUtils::MakeMaker;
# See lib/ExtUtils/MakeMaker.pm for details of how to influence
# the contents of the Makefile that is written.
WriteMakefile(
    NAME              => 'HeliosX::Logger::File',
    VERSION_FROM      => 'lib/HeliosX/Logger/File.pm', # finds $VERSION
    LICENSE           => 'artistic_2',
    PREREQ_PM         => {
    						Helios => 2.31
    						}, # e.g., Module::Name => 1.1
    ($] >= 5.005 ?     ## Add these new keywords supported since 5.005
      (ABSTRACT_FROM  => 'lib/HeliosX/Logger/File.pm', # retrieve abstract from module
       AUTHOR         => 'Andrew Johnson <lajandy at cpan dotorg>') : ()),
);
