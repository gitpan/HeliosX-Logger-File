package HeliosX::Logger::File;

use 5.008000;
use strict;
use warnings;
use base 'Helios::Logger';
use File::Spec;

use Helios::LogEntry::Levels ':all';
use Helios::Error::LoggingError;

our $VERSION = '0.01_0221';

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
		or Helios::Error::LoggingError->throw('open() failed: '.$!); 
	
}


sub logMsg {
	my $self = shift;
	my $job = shift;
	my $priority = shift;
	my $message = shift;
	my $c = $self->getConfig();
	
	if ( defined($c->{logfile_threshold})
		&& ($priority > $c->{logfile_threshold}) )
	{
		return 0;
	}
	
	print $LogFH $self->assembleMsg($job, $priority, $message),"\n";
}


sub assembleMsg {
	return scalar(localtime()).' '.$_[0]->getJobType().' Job '.$_[1]->getJobid().' '.$_[3];
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
