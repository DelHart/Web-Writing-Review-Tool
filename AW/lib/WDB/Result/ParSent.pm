package WDB::Result::ParSent;

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

WDB::Result::ParSent

=cut

__PACKAGE__->table("par_sents");

=head1 ACCESSORS

=head2 paragraph

  data_type: 'integer'
  is_nullable: 0

=head2 paragraph_rev

  data_type: 'integer'
  is_nullable: 0

=head2 sentence

  data_type: 'integer'
  is_nullable: 0

=head2 sentence_rev

  data_type: 'integer'
  is_nullable: 0

=head2 num

  data_type: 'integer'
  is_nullable: 0

=cut

__PACKAGE__->add_columns(
  "paragraph",
  { data_type => "integer", is_nullable => 0 },
  "paragraph_rev",
  { data_type => "integer", is_nullable => 0 },
  "sentence",
  { data_type => "integer", is_nullable => 0 },
  "sentence_rev",
  { data_type => "integer", is_nullable => 0 },
  "num",
  { data_type => "integer", is_nullable => 0 },
);
__PACKAGE__->set_primary_key("paragraph", "paragraph_rev", "sentence", "sentence_rev", "num");


# Created by DBIx::Class::Schema::Loader v0.07010 @ 2011-07-09 14:35:03
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:KsyMFKKrcjFjtmkZk42PRw


# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
