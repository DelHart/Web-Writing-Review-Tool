package WDB::Result::AssignmentPerson;

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

WDB::Result::AssignmentPerson

=cut

__PACKAGE__->table("assignment_person");

=head1 ACCESSORS

=head2 assignment

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 0

=head2 person

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 0

=head2 status

  data_type: 'integer'
  is_nullable: 1

=head2 essay

  data_type: 'integer'
  is_nullable: 1

=cut

__PACKAGE__->add_columns(
  "assignment",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 0 },
  "person",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 0 },
  "status",
  { data_type => "integer", is_nullable => 1 },
  "essay",
  { data_type => "integer", is_nullable => 1 },
);
__PACKAGE__->set_primary_key("assignment", "person");

=head1 RELATIONS

=head2 assignment

Type: belongs_to

Related object: L<WDB::Result::Assignment>

=cut

__PACKAGE__->belongs_to(
  "assignment",
  "WDB::Result::Assignment",
  { assignment => "assignment" },
  { is_deferrable => 1, on_delete => "CASCADE", on_update => "CASCADE" },
);

=head2 person

Type: belongs_to

Related object: L<WDB::Result::Person>

=cut

__PACKAGE__->belongs_to(
  "person",
  "WDB::Result::Person",
  { uid_num => "person" },
  { is_deferrable => 1, on_delete => "CASCADE", on_update => "CASCADE" },
);


# Created by DBIx::Class::Schema::Loader v0.07010 @ 2011-07-11 23:12:05
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:d6ZS2FtFN/0178MSzid/vw


__PACKAGE__->belongs_to(
  "current_essay",
  "WDB::Result::CurrentEssay",
  { essay => "essay" },
  {
    is_deferrable => 1,
    join_type     => "LEFT",
    on_delete     => "CASCADE",
    on_update     => "CASCADE",
  },
);


# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
