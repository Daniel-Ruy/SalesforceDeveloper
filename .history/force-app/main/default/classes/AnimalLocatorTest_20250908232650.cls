@isTest
public with sharing class AnimalLocatorTest {
  @isTest
  Test.setMock(HttpCalloutMock.class, new AnimalLocatorMock());

}