package WDB::Result::Assignment;

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

WDB::Result::Assignment

=cut

__PACKAGE__->table("assignment");

=head1 ACCESSORS

=head2 assignment

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0
  sequence: 'id_seq'

=head2 info

  data_type: 'text'
  is_nullable: 1

=head2 due_date

  data_type: 'integer'
  is_nullable: 1

=head2 group

  data_type: 'integer'
  default_value: 1
  is_nullable: 1

=head2 essay

  data_type: 'integer'
  is_nullable: 1

=head2 revision

  data_type: 'integer'
  is_nullable: 1

=head2 name

  data_type: 'text'
  is_nullable: 1

=head2 url

  data_type: 'text'
  is_nullable: 1

=cut

__PACKAGE__->add_columns(
  "assignment",
  {
    data_type         => "integer",
    is_auto_increment => 1,
    is_nullable       => 0,
    sequence          => "id_seq",
  },
  "info",
  { data_type => "text", is_nullable => 1 },
  "due_date",
  { data_type => "integer", is_nullable => 1 },
  "group",
  { data_type => "integer", default_value => 1, is_nullable => 1 },
  "essay",
  { data_type => "integer", is_nullable => 1 },
  "revision",
  { data_type => "integer", is_nullable => 1 },
  "name",
  { data_type => "text", is_nullable => 1 },
  "url",
  { data_type => "text", is_nullable => 1 },
);
__PACKAGE__->set_primary_key("assignment");

=head1 RELATIONS

=head2 assignment_people

Type: has_many

Related object: L<WDB::Result::AssignmentPerson>

=cut

__PACKAGE__->has_many(
  "assignment_people",
  "WDB::Result::AssignmentPerson",
  { "foreign.assignment" => "self.assignment" },
  { cascade_copy => 0, cascade_delete => 0 },
);


# Created by DBIx::Class::Schema::Loader v0.07010 @ 2011-07-11 15:42:54
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:zN7bJVSRCIGzb6WJAsNXWg


# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
