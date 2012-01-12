package HeliosX::Logger::File;

use 5.008000;
use strict;
use warnings;
use base 'Helios::Logger';
use File::Spec;

use Helios::LogEntry::Levels ':all';
use Helios::Error;

our $VERSION = '0.01_0232';

our $LogFH;
our $LogFilename;

sub init {
	my $self = shift;
	my $c = $self->getConfig();
	
	unless ( defined($c->{logfile_path}) ) {
		Helios::Error::LoggingError->throw('logfile_path config parameter not specified');
	}
	
	# open the file
	$LogFilename = File::Spec->catfile($c->{logfile_path},$$.'.log'); 
	open($LogFH, '>>', $LogFilename) 
		or Helios::Error::LoggingError->throw("Failed to open() '$LogFilename': ".$!); 
	
}


sub logMsg {
	my $self = shift;
	my $j = shift;
	my $p = shift;
	my $m = shift;
	my $c = $self->getConfig();
	
	if ( defined($c->{logfile_priority_threshold})
		&& ($p > $c->{logfile_priority_threshold}) )
	{
		return 0;
	}
	
	print $LogFH $self->assembleMsg($j,$p,$m),"\n";
}


sub assembleMsg {
	my ($self, $j, $p, $m) = @_;
    if ( defined($j) ) { 
		return '['.scalar(localtime()).'] ['.$p.'] ['.$self->getJobType().'] [Job '.$j->getJobid().'] '.$m;
    } else {
		return '['.scalar(localtime()).'] ['.$p.'] ['.$self->getJobType().'] '.$m;
    }


}


1;
__END__
# Below is stub documentation for your module. You'd better edit it!

=head1 NAME

HeliosX::Logger::File - Helios::Logger to log to a file on disk

=head1 SYNOPSIS

  # in helios.ini
  loggers=HeliosX::Logger::File
  logfile_path=/var/log/helios/
  logfile_threshold=6

=head1 DESCRIPTION

HeliosX::Logger::File is a Helios::Logger class to send Helios log messages 
directly to a file.  Its intended to be a debugging tool for diagnosing 
problems with Helios worker processes.

=head1 SEE ALSO

L<Helios>, L<Helios::Logger>

=head1 AUTHOR

Andrew Johnson, E<lt>lajandy at cpan dotorgE<gt>

=head1 COPYRIGHT AND LICENSE

This library is free software; you can redistribute it and/or
modify it under the terms of the Artistic License 2.0.

=head1 WARRANTY

This program is distributed in the hope that it will be useful,
but without any warranty; without even the implied warranty of
merchantability or fitness for a particular purpose.

This software comes with no warranty of any kind.

=cut
