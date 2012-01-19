package WDB::Result::Essay;

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

WDB::Result::Essay

=cut

__PACKAGE__->table("essay");

=head1 ACCESSORS

=head2 essay

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

=head2 author

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 1

=head2 derived

  data_type: 'boolean'
  default_value: false
  is_nullable: 1

=head2 parent

  data_type: 'integer'
  is_nullable: 1

=head2 title

  data_type: 'text'
  is_nullable: 1

=head2 status

  data_type: 'integer'
  is_nullable: 1

=head2 approach

  data_type: 'text'
  is_nullable: 1

=head2 assignment

  data_type: 'integer'
  is_nullable: 1

=head2 counter

  data_type: 'integer'
  default_value: 1
  is_nullable: 0

provides namespace ids for paragraphs and other local data structures

=head2 parent_revision

  data_type: 'integer'
  is_nullable: 1

=cut

__PACKAGE__->add_columns(
  "essay",
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
  "author",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 1 },
  "derived",
  { data_type => "boolean", default_value => \"false", is_nullable => 1 },
  "parent",
  { data_type => "integer", is_nullable => 1 },
  "title",
  { data_type => "text", is_nullable => 1 },
  "status",
  { data_type => "integer", is_nullable => 1 },
  "approach",
  { data_type => "text", is_nullable => 1 },
  "assignment",
  { data_type => "integer", is_nullable => 1 },
  "counter",
  { data_type => "integer", default_value => 1, is_nullable => 0 },
  "parent_revision",
  { data_type => "integer", is_nullable => 1 },
);
__PACKAGE__->set_primary_key("essay", "revision");

=head1 RELATIONS

=head2 author

Type: belongs_to

Related object: L<WDB::Result::Person>

=cut

__PACKAGE__->belongs_to(
  "author",
  "WDB::Result::Person",
  { uid_num => "author" },
  {
    is_deferrable => 1,
    join_type     => "LEFT",
    on_delete     => "CASCADE",
    on_update     => "CASCADE",
  },
);

=head2 essay_erefs

Type: has_many

Related object: L<WDB::Result::EssayEref>

=cut

__PACKAGE__->has_many(
  "essay_erefs",
  "WDB::Result::EssayEref",
  {
    "foreign.essay"     => "self.essay",
    "foreign.essay_rev" => "self.revision",
  },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 logs

Type: has_many

Related object: L<WDB::Result::Log>

=cut

__PACKAGE__->has_many(
  "logs",
  "WDB::Result::Log",
  {
    "foreign.essay"     => "self.essay",
    "foreign.essay_rev" => "self.revision",
  },
  { cascade_copy => 0, cascade_delete => 0 },
);


# Created by DBIx::Class::Schema::Loader v0.07010 @ 2011-09-04 23:36:57
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:GlkQy8idvg/S7Zfg4SwYLg


# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
