package WDB::Result::Eref;

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

WDB::Result::Eref

=cut

__PACKAGE__->table("eref");

=head1 ACCESSORS

=head2 eref

  data_type: 'integer'
  is_nullable: 0

=head2 revision

  data_type: 'integer'
  is_nullable: 0

=head2 essay

  data_type: 'integer'
  is_nullable: 0

=head2 date_created

  data_type: 'integer'
  default_value: date_part('epoch'::text, now())
  is_nullable: 1

=head2 utility

  data_type: 'text'
  is_nullable: 1

=head2 url

  data_type: 'text'
  is_nullable: 1

=head2 nickname

  data_type: 'text'
  is_nullable: 1

=cut

__PACKAGE__->add_columns(
  "eref",
  { data_type => "integer", is_nullable => 0 },
  "revision",
  { data_type => "integer", is_nullable => 0 },
  "essay",
  { data_type => "integer", is_nullable => 0 },
  "date_created",
  {
    data_type     => "integer",
    default_value => \"date_part('epoch'::text, now())",
    is_nullable   => 1,
  },
  "utility",
  { data_type => "text", is_nullable => 1 },
  "url",
  { data_type => "text", is_nullable => 1 },
  "nickname",
  { data_type => "text", is_nullable => 1 },
);
__PACKAGE__->set_primary_key("eref", "revision", "essay");

=head1 RELATIONS

=head2 essay_erefs

Type: has_many

Related object: L<WDB::Result::EssayEref>

=cut

__PACKAGE__->has_many(
  "essay_erefs",
  "WDB::Result::EssayEref",
  {
    "foreign.eref"     => "self.eref",
    "foreign.eref_rev" => "self.revision",
    "foreign.essay"    => "self.essay",
  },
  { cascade_copy => 0, cascade_delete => 0 },
);


# Created by DBIx::Class::Schema::Loader v0.07010 @ 2011-07-20 15:32:11
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:5jLHJiY4iajivsaLWpdpVw


# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
