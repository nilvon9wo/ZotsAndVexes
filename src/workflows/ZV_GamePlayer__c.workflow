<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <fieldUpdates>
        <fullName>Create_Unique_Play_Order_Key</fullName>
        <field>PlayOrderKey__c</field>
        <formula>Game__c  &amp; &quot;:&quot; &amp; Player__c &amp; &quot;:&quot; &amp; TEXT(PlayOrder__c)</formula>
        <name>Create Unique Play Order Key</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <rules>
        <fullName>Create Unique Play Order Key</fullName>
        <actions>
            <name>Create_Unique_Play_Order_Key</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>ZV_GamePlayer__c.PlayOrder__c</field>
            <operation>greaterThan</operation>
            <value>-1</value>
        </criteriaItems>
        <triggerType>onAllChanges</triggerType>
    </rules>
</Workflow>
