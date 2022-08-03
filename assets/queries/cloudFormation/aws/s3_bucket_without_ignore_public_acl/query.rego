package Cx

import data.generic.common as common_lib
import data.generic.cloudformation as cf_lib

CxPolicy[result] {
	resource := input.document[i].Resources[name]
	resource.Type == "AWS::S3::Bucket"

	Properties := resource.Properties
	not common_lib.valid_key(Properties, "PublicAccessBlockConfiguration") 

	result := {
		"documentId": input.document[i].id,
		"resourceType": resource.Type,
		"resourceName": cf_lib.get_resource_name(resource, name),
		"searchKey": sprintf("Resources.%s.Properties", [name]),
		"issueType": "MissingAttribute",
		"keyExpectedValue": sprintf("'PublicAccessBlockConfiguration' should be defined", [name]),
		"keyActualValue": sprintf("'PublicAccessBlockConfiguration' is not defined", [name]),
		"searchLine": common_lib.build_search_line(["Resources", name, "Properties"], []),
	}
}

CxPolicy[result] {
	resource := input.document[i].Resources[name]
	resource.Type == "AWS::S3::Bucket"

	PublicAccessBlockConfiguration := resource.Properties.PublicAccessBlockConfiguration
	not common_lib.valid_key(PublicAccessBlockConfiguration, "IgnorePublicAcls") 

	result := {
		"documentId": input.document[i].id,
		"resourceType": resource.Type,
		"resourceName": cf_lib.get_resource_name(resource, name),
		"searchKey": sprintf("Resources.%s.Properties.PublicAccessBlockConfiguration", [name]),
		"issueType": "MissingAttribute",
		"keyExpectedValue": sprintf("'IgnorePublicAcls' should be defined and set to true in the 'PublicAccessBlockConfiguration'", [name]),
		"keyActualValue": sprintf("'IgnorePublicAcls' is not defined in the 'PublicAccessBlockConfiguration'", [name]),
		"searchLine": common_lib.build_search_line(["Resources", name, "Properties", "PublicAccessBlockConfiguration"], []),
	}
}

CxPolicy[result] {
	resource := input.document[i].Resources[name]
	resource.Type == "AWS::S3::Bucket"

	PublicAccessBlockConfiguration := resource.Properties.PublicAccessBlockConfiguration
	PublicAccessBlockConfiguration.IgnorePublicAcls == false 

	result := {
		"documentId": input.document[i].id,
		"resourceType": resource.Type,
		"resourceName": cf_lib.get_resource_name(resource, name),
		"searchKey": sprintf("Resources.%s.Properties.PublicAccessBlockConfiguration.IgnorePublicAcls", [name]),
		"issueType": "IncorrectValue",
		"keyExpectedValue": sprintf("'IgnorePublicAcls' should be set to true", [name]),
		"keyActualValue": sprintf("'IgnorePublicAcls' is set to false", [name]),
		"searchLine": common_lib.build_search_line(["Resources", name, "Properties", "PublicAccessBlockConfiguration", "IgnorePublicAcls"], []),
	}
}
