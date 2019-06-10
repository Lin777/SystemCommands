"
I am a command to rename temp variable in given method.
 
Internal Representation and Key Implementation Points.

    Instance Variables
	newName:		<String>
"
Class {
	#name : #SycRenameTempCommand,
	#superclass : #SycSourceCodeCommand,
	#instVars : [
		'newName'
	],
	#category : #'SystemCommands-SourceCodeCommands'
}

{ #category : #execution }
SycRenameTempCommand class >> canBeExecutedInContext: aSourceCodeContext [
	super canBeExecutedInContext: aSourceCodeContext.
	
	^aSourceCodeContext isTempVariableSelected 
]

{ #category : #execution }
SycRenameTempCommand >> applyResultInContext: aSourceCodeContext [
	super applyResultInContext: aSourceCodeContext.
	
	aSourceCodeContext showVariableNamed: newName
]

{ #category : #accessing }
SycRenameTempCommand >> defaultMenuItemName [
	^'Rename temp'
]

{ #category : #execution }
SycRenameTempCommand >> executeRefactoringsOf: interactiveLayer [
	^ interactiveLayer renameTempWithName: newName withPerform: #primitiveExecute
]

{ #category : #execution }
SycRenameTempCommand >> prepareFullExecutionInContext: aSourceCodeContext [
	super prepareFullExecutionInContext: aSourceCodeContext.
	
	newName := UIManager default 
		request: 'New name of the variable' 
		initialAnswer: sourceNode name
		title: 'Rename a temp variable'.
	newName isEmptyOrNil | (newName = sourceNode name) ifTrue: [ CmdCommandAborted signal ]
]
