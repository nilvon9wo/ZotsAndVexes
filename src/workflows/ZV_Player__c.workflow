<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <fieldUpdates>
        <fullName>Transcribe_User</fullName>
        <field>UserId__c</field>
        <formula>User__c</formula>
        <name>Transcribe User</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <rules>
        <fullName>Transcribe User</fullName>
        <actions>
            <name>Transcribe_User</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <formula>NOT(ISNULL(User__c))</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
</Workflow>
