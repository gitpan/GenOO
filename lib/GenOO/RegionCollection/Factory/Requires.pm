# POD documentation - main docs before the code

=head1 NAME

GenOO::RegionCollection::Factory::Requires - Role for a concrete factory that creates GenOO::RegionCollection objects

=head1 DESCRIPTION

    Concrete factories should implement the interface defined in this role

=cut

# Let the code begin...

package GenOO::RegionCollection::Factory::Requires;
$GenOO::RegionCollection::Factory::Requires::VERSION = '1.4.5';
use Moose::Role;

requires 'read_collection';

1;
