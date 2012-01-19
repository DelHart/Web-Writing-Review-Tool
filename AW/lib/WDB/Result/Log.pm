package WDB::Result::Log;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

use strict;
use warnings;

use Moose;
use MooseX::NonMoose;
use namespace::autoclean;
extends 'DBIx::Class::Core';

__PACKAGE__->load_components("InflateColumn::DateTime");

=head1 NAME

WDB::Result::Log

=cut

__PACKAGE__->table("log");

=head1 ACCESSORS

=head2 essay

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 0

=head2 essay_rev

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 0

=head2 kind

  data_type: 'integer'
  is_nullable: 1

=head2 id

  data_type: 'integer'
  is_nullable: 0

=head2 id_rev

  data_type: 'integer'
  is_nullable: 0

=head2 times

  data_type: 'integer[]'
  is_nullable: 1

=head2 keys

  data_type: 'integer[]'
  is_nullable: 1

=cut

__PACKAGE__->add_columns(
  "essay",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 0 },
  "essay_rev",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 0 },
  "kind",
  { data_type => "integer", is_nullable => 1 },
  "id",
  { data_type => "integer", is_nullable => 0 },
  "id_rev",
  { data_type => "integer", is_nullable => 0 },
  "times",
  { data_type => "integer[]", is_nullable => 1 },
  "keys",
  { data_type => "integer[]", is_nullable => 1 },
);
__PACKAGE__->set_primary_key("essay", "essay_rev", "id", "id_rev");

=head1 RELATIONS

=head2 essay

Type: belongs_to

Related object: L<WDB::Result::Essay>

=cut

__PACKAGE__->belongs_to(
  "essay",
  "WDB::Result::Essay",
  { essay => "essay", revision => "essay_rev" },
  { is_deferrable => 1, on_delete => "CASCADE", on_update => "CASCADE" },
);


# Created by DBIx::Class::Schema::Loader v0.07010 @ 2011-09-05 00:34:18
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:eP4tGlid/lE9OWy496V0uA


# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
