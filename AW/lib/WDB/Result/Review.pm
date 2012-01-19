package WDB::Result::Review;

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

WDB::Result::Review

=cut

__PACKAGE__->table("review");

=head1 ACCESSORS

=head2 review

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0
  sequence: 'id_seq'

=head2 revision

  data_type: 'integer'
  default_value: 1
  is_nullable: 0

=head2 reviewer

  data_type: 'integer'
  is_nullable: 1

=head2 essay

  data_type: 'integer'
  is_nullable: 1

=head2 essay_rev

  data_type: 'integer'
  is_nullable: 1

=head2 focus

  data_type: 'integer'
  default_value: 0
  is_nullable: 1

=head2 evidence

  data_type: 'integer'
  default_value: 0
  is_nullable: 1

=head2 presentation

  data_type: 'integer'
  default_value: 0
  is_nullable: 1

=head2 insight

  data_type: 'integer'
  default_value: 0
  is_nullable: 1

=head2 quantity

  data_type: 'integer'
  default_value: 0
  is_nullable: 1

=head2 overall

  data_type: 'integer'
  default_value: 0
  is_nullable: 1

=head2 create_date

  data_type: 'integer'
  default_value: date_part('epoch'::text, now())
  is_nullable: 1

=head2 comment

  data_type: 'text'
  is_nullable: 1

=head2 sufficiency

  data_type: 'integer'
  default_value: 0
  is_nullable: 1

=cut

__PACKAGE__->add_columns(
  "review",
  {
    data_type         => "integer",
    is_auto_increment => 1,
    is_nullable       => 0,
    sequence          => "id_seq",
  },
  "revision",
  { data_type => "integer", default_value => 1, is_nullable => 0 },
  "reviewer",
  { data_type => "integer", is_nullable => 1 },
  "essay",
  { data_type => "integer", is_nullable => 1 },
  "essay_rev",
  { data_type => "integer", is_nullable => 1 },
  "focus",
  { data_type => "integer", default_value => 0, is_nullable => 1 },
  "evidence",
  { data_type => "integer", default_value => 0, is_nullable => 1 },
  "presentation",
  { data_type => "integer", default_value => 0, is_nullable => 1 },
  "insight",
  { data_type => "integer", default_value => 0, is_nullable => 1 },
  "quantity",
  { data_type => "integer", default_value => 0, is_nullable => 1 },
  "overall",
  { data_type => "integer", default_value => 0, is_nullable => 1 },
  "create_date",
  {
    data_type     => "integer",
    default_value => \"date_part('epoch'::text, now())",
    is_nullable   => 1,
  },
  "comment",
  { data_type => "text", is_nullable => 1 },
  "sufficiency",
  { data_type => "integer", default_value => 0, is_nullable => 1 },
);
__PACKAGE__->set_primary_key("review", "revision");


# Created by DBIx::Class::Schema::Loader v0.07010 @ 2011-10-23 00:35:51
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:zD2/cdxvu4f7M/OqpABsaQ


# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
