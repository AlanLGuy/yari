@feature_tag
Feature: A simple feature
  Background:
    Given we live in monster world

  @scenario_tag
  Scenario: A simple scenario
    Given there is a monster
    When I attack it
    Then it should die

  Scenario: Raising error
    When Running this scenario
    Then Error should be raisen

  Scenario: Different metadata type
    When Running this scenario
    Then Type of this scenario should be :controller

  Scenario: Custom metadata tag
    When Running this scenario
    Then Metadata should contain :custom key with 'foobar' value
