# POD documentation - main docs before the code

=head1 NAME

GenOO::Exon - Exon object

=head1 SYNOPSIS

    # This object represents an exon of a transcript
    # It extends the L<GenOO::GenomicRegion> object
    
    # To initialize 
    GenOO::Exon->new(
        species      => undef,
        strand       => undef,           #required
        chromosome   => undef,           #required
        start        => undef,           #required
        stop         => undef,           #required
        part_of      => reference to a transcript object
    );

=head1 DESCRIPTION

    The exon class describes an exon of a transcript.
    It requires a strand (1,-1), a chromosome name, a genomic start and stop position (start is always the
    smallest coordinate in the genome and NOT the 5p of the exon - i.e. if the exon is in the -1 strand
    the start coordinate will be the 3p of the exon)
    See L<GenOO::Region> and for more available methods

=head1 EXAMPLES

    my $exon = GenOO::Exon->new(
        strand       => 1,                 #required
        chromosome   => 'chr11',           #required
        start        => 8893144,           #required
        stop         => 8911139,           #required
    );
   my $exon_start = $exon->start; #8893144

=cut

# Let the code begin...

package GenOO::Exon;

use Moose;
use namespace::autoclean;

extends 'GenOO::GenomicRegion';

has 'part_of' => (is => 'rw', weak_ref => 1);


__PACKAGE__->meta->make_immutable;

1;