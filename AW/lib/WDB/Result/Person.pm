package WDB::Result::Person;

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

WDB::Result::Person

=cut

__PACKAGE__->table("person");

=head1 ACCESSORS

=head2 uid

  data_type: 'text'
  is_nullable: 0

=head2 uid_num

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 1
  sequence: 'id_seq'

=head2 sur_name

  data_type: 'text'
  is_nullable: 1

=head2 given_name

  data_type: 'text'
  is_nullable: 1

=head2 banner_num

  data_type: 'integer'
  default_value: 0
  is_nullable: 1

=head2 mail_addr

  data_type: 'text'
  is_nullable: 1

=head2 common_name

  data_type: 'text'
  is_nullable: 1

=head2 active

  data_type: 'boolean'
  default_value: true
  is_nullable: 1

=cut

__PACKAGE__->add_columns(
  "uid",
  { data_type => "text", is_nullable => 0 },
  "uid_num",
  {
    data_type         => "integer",
    is_auto_increment => 1,
    is_nullable       => 1,
    sequence          => "id_seq",
  },
  "sur_name",
  { data_type => "text", is_nullable => 1 },
  "given_name",
  { data_type => "text", is_nullable => 1 },
  "banner_num",
  { data_type => "integer", default_value => 0, is_nullable => 1 },
  "mail_addr",
  { data_type => "text", is_nullable => 1 },
  "common_name",
  { data_type => "text", is_nullable => 1 },
  "active",
  { data_type => "boolean", default_value => \"true", is_nullable => 1 },
);
__PACKAGE__->set_primary_key("uid");
__PACKAGE__->add_unique_constraint("person_uidnum_unique", ["uid_num"]);

=head1 RELATIONS

=head2 assignment_people

Type: has_many

Related object: L<WDB::Result::AssignmentPerson>

=cut

__PACKAGE__->has_many(
  "assignment_people",
  "WDB::Result::AssignmentPerson",
  { "foreign.person" => "self.uid_num" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 essays

Type: has_many

Related object: L<WDB::Result::Essay>

=cut

__PACKAGE__->has_many(
  "essays",
  "WDB::Result::Essay",
  { "foreign.author" => "self.uid_num" },
  { cascade_copy => 0, cascade_delete => 0 },
);


# Created by DBIx::Class::Schema::Loader v0.07010 @ 2011-09-04 23:37:39
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:db6Dm6ttMSYpV5xdDVyZiA


# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
