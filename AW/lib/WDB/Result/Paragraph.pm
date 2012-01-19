package WDB::Result::Paragraph;

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

WDB::Result::Paragraph

=cut

__PACKAGE__->table("paragraph");

=head1 ACCESSORS

=head2 paragraph

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0
  sequence: 'id_seq'

=head2 revision

  data_type: 'integer'
  default_value: 1
  is_nullable: 0

=head2 date_created

  data_type: 'integer'
  default_value: date_part('epoch'::text, now())
  is_nullable: 1

=head2 derived

  data_type: 'boolean'
  default_value: false
  is_nullable: 1

=head2 parent

  data_type: 'integer'
  is_nullable: 1

=head2 idea

  data_type: 'text'
  is_nullable: 1

=head2 essay

  data_type: 'integer'
  default_value: 0
  is_nullable: 0

=head2 words

  data_type: 'text[]'
  is_nullable: 1

=cut

__PACKAGE__->add_columns(
  "paragraph",
  {
    data_type         => "integer",
    is_auto_increment => 1,
    is_nullable       => 0,
    sequence          => "id_seq",
  },
  "revision",
  { data_type => "integer", default_value => 1, is_nullable => 0 },
  "date_created",
  {
    data_type     => "integer",
    default_value => \"date_part('epoch'::text, now())",
    is_nullable   => 1,
  },
  "derived",
  { data_type => "boolean", default_value => \"false", is_nullable => 1 },
  "parent",
  { data_type => "integer", is_nullable => 1 },
  "idea",
  { data_type => "text", is_nullable => 1 },
  "essay",
  { data_type => "integer", default_value => 0, is_nullable => 0 },
  "words",
  { data_type => "text[]", is_nullable => 1 },
);
__PACKAGE__->set_primary_key("paragraph", "revision", "essay");


# Created by DBIx::Class::Schema::Loader v0.07010 @ 2011-07-17 10:55:24
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:gTRfhrSs3ZUII0ZkZOIa8g


# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
