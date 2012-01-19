package WDB::Result::GroupMember;

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

WDB::Result::GroupMember

=cut

__PACKAGE__->table("group_member");

=head1 ACCESSORS

=head2 club

  data_type: 'integer'
  is_nullable: 0

=head2 person

  data_type: 'integer'
  is_nullable: 0

=cut

__PACKAGE__->add_columns(
  "club",
  { data_type => "integer", is_nullable => 0 },
  "person",
  { data_type => "integer", is_nullable => 0 },
);
__PACKAGE__->set_primary_key("club", "person");


# Created by DBIx::Class::Schema::Loader v0.07010 @ 2011-09-04 23:37:39
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:frVMh4xYbI0w19aTZ+L8ug


# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
