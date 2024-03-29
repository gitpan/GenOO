# POD documentation - main docs before the code

=head1 NAME

GenOO::Data::File::FASTA - Object implementing methods for accessing fasta formatted files (http://genome.ucsc.edu/FAQ/FAQformat#format1)

=head1 SYNOPSIS

    # Object that manages a fasta file.

    # To initialize
    my $fasta_parser = GenOO::Data::File::FASTA->new(
        file            => undef,
    );

=head1 DESCRIPTION

    This object offers methods to read a fasta file line by line.

=head1 EXAMPLES

    # Create object
    my $fasta_parser = GenOO::Data::File::FASTA->new(
          file => 't/sample_data/sample.fasta.gz'
    );

    # Read one record at a time
    my $record = $fasta_parser->next_record;

    # Get the number of records read
    my $count = $fasta_parser->records_read_count;

=cut

# Let the code begin...

package GenOO::Data::File::FASTA;
$GenOO::Data::File::FASTA::VERSION = '1.4.5';

#######################################################################
#######################   Load External modules   #####################
#######################################################################
use Modern::Perl;
use autodie;
use Moose;
use namespace::autoclean;


#######################################################################
#########################   Load GenOO modules   ######################
#######################################################################
use GenOO::Data::File::FASTA::Record;


#######################################################################
#######################   Interface attributes   ######################
#######################################################################
has 'file' => (
	isa      => 'Maybe[Str]',
	is       => 'rw',
	required => 1
);

has 'records_read_count' => (
	is        => 'rw',
	default   => 0,
	init_arg  => undef,
);

has '_filehandle' => (
	is        => 'ro',
	builder   => '_open_filehandle',
	init_arg  => undef,
	lazy      => 1,
);

has '_stored_record_header' => (
	is        => 'rw',
	clearer   => '_clear_stored_record_header',
	predicate => '_has_stored_record_header',
	init_arg  => undef,
);

has '_stored_record_sequence_parts' => (
        traits  => ['Array'],
        is      => 'rw',
        isa     => 'ArrayRef[Str]',
        default => sub { [] },
        handles => {
            _all_record_sequence_parts    => 'elements',
            _add_record_sequence_part     => 'push',
            _join_record_sequence_parts   => 'join',
            _clear_record_sequence_parts  => 'clear',
        },
    );

has '_eof' => (
	is        => 'rw',
	predicate => '_reached_eof',
	init_arg  => undef
);


#######################################################################
########################   Interface Methods   ########################
#######################################################################
sub next_record {
	my ($self) = @_;

	return undef if ($self->_reached_eof);

	while (my $line = $self->_filehandle->getline) {
		chomp $line;
		if (_line_looks_like_record_header($line)) {
			if ($self->_has_stored_record_header) {
				my $record = $self->_create_record;
				$self->_stored_record_header($line);
				return $record;
			}
			else {
				$self->_stored_record_header($line);
			}
		}
		elsif (_line_looks_like_sequence($line)) {
			$self->_add_record_sequence_part($line);
		}
	}
	$self->_eof(1);
	return $self->_create_record;
}

#######################################################################
#########################   Private methods  ##########################
#######################################################################
sub _open_filehandle {
	my ($self) = @_;

	my $read_mode;
	my $HANDLE;
	if (!defined $self->file) {
		open ($HANDLE, '<-', $self->file);
	}
	elsif ($self->file =~ /\.gz$/) {
		die 'Cannot open file ' . $self->file . "\n" if ! -e $self->file;
		open($HANDLE, 'gzip -dc ' . $self->file . ' |');
	}
	else {
		open ($HANDLE, '<', $self->file);
	}

	return $HANDLE;
}

sub _increment_records_read_count {
	my ($self) = @_;
	$self->records_read_count($self->records_read_count+1);
}

sub _create_record {
	my ($self) = @_;

	my $record = GenOO::Data::File::FASTA::Record->new(
		header   => $self->_stored_record_header,
		sequence => $self->_join_record_sequence_parts(''),
	);
	$self->_clear_stored_record_header;
	$self->_clear_record_sequence_parts;
	$self->_increment_records_read_count;

	return $record;
}


#######################################################################
#######################   Private subroutines  ########################
#######################################################################
sub _line_looks_like_record_header {
	return ($_[0] =~ /^>/) ? 1 : 0;
}

sub _line_looks_like_sequence {
	return ((!_line_looks_like_record_header($_[0])) and ($_[0] =~ /\S/)) ? 1 : 0;
}


#######################################################################
############################   Finalize   #############################
#######################################################################
__PACKAGE__->meta->make_immutable;

1;
