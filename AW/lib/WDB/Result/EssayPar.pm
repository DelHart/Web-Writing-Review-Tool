package WDB::Result::EssayPar;

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

WDB::Result::EssayPar

=cut

__PACKAGE__->table("essay_pars");

=head1 ACCESSORS

=head2 essay

  data_type: 'integer'
  is_nullable: 0

=head2 essay_rev

  data_type: 'integer'
  is_nullable: 0

=head2 paragraph

  data_type: 'integer'
  is_nullable: 0

=head2 paragraph_rev

  data_type: 'integer'
  is_nullable: 0

=head2 num

  data_type: 'integer'
  is_nullable: 0

=cut

__PACKAGE__->add_columns(
  "essay",
  { data_type => "integer", is_nullable => 0 },
  "essay_rev",
  { data_type => "integer", is_nullable => 0 },
  "paragraph",
  { data_type => "integer", is_nullable => 0 },
  "paragraph_rev",
  { data_type => "integer", is_nullable => 0 },
  "num",
  { data_type => "integer", is_nullable => 0 },
);
__PACKAGE__->set_primary_key("essay", "essay_rev", "paragraph", "paragraph_rev", "num");


# Created by DBIx::Class::Schema::Loader v0.07010 @ 2011-07-09 14:35:03
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:jN101SOYjsuWxfC4BkFxBg


# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
