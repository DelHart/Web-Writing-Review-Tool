package WDB::Result::EssayEref;

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

WDB::Result::EssayEref

=cut

__PACKAGE__->table("essay_eref");

=head1 ACCESSORS

=head2 essay

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 0

=head2 essay_rev

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 0

=head2 eref

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 0

=head2 eref_rev

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 0

=cut

__PACKAGE__->add_columns(
  "essay",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 0 },
  "essay_rev",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 0 },
  "eref",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 0 },
  "eref_rev",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 0 },
);
__PACKAGE__->set_primary_key("essay", "essay_rev", "eref", "eref_rev");

=head1 RELATIONS

=head2 eref

Type: belongs_to

Related object: L<WDB::Result::Eref>

=cut

__PACKAGE__->belongs_to(
  "eref",
  "WDB::Result::Eref",
  { eref => "eref", essay => "essay", revision => "eref_rev" },
  { is_deferrable => 1, on_delete => "CASCADE", on_update => "CASCADE" },
);

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


# Created by DBIx::Class::Schema::Loader v0.07010 @ 2011-07-20 15:20:44
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:8VQ+giyRFgzPaPTSKldZ0w


# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
