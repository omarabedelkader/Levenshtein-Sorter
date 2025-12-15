Class {
	#name : 'LevenshteinSorter',
	#superclass : 'CompletionSorter',
	#category : 'Levenshtein-Sorter',
	#package : 'Levenshtein-Sorter'
}

{ #category : 'sorting' }
LevenshteinSorter >> labelForEntry: anEntry [
        "Extract the most descriptive label from a completion entry."

        anEntry ifNil: [ ^ '' ].
        (anEntry respondsTo: #label)
                ifTrue: [ ^ (anEntry perform: #label) asString ].
        (anEntry respondsTo: #text)
                ifTrue: [ ^ (anEntry perform: #text) asString ].
        ^ anEntry asString
]

{ #category : 'sorting' }
LevenshteinSorter >> levenshteinDistanceBetween: aString and: anotherString [
	"Compute the Levenshtein distance between two strings."

	| source target previous current |
	aString ifNil: [ ^ anotherString size ].
	anotherString ifNil: [ ^ aString size ].

	source := aString asString.
	target := anotherString asString.

	previous := (0 to: target size) asArray.

	1 to: source size do: [ :i |
			current := Array new: target size + 1.
			current at: 1 put: i.

			1 to: target size do: [ :j |
					| cost |
					cost := (source at: i) = (target at: j)
						        ifTrue: [ 0 ]
						        ifFalse: [ 1 ].

					current at: j + 1 put: (((current at: j) + 1 min: (previous at: j + 1) + 1) min: (previous at: j) + cost) ].

			previous := current ].

	^ previous last
]

{ #category : 'sorting' }
LevenshteinSorter >> sortCompletionList: aCompletionList [

	| prefix |
	aCompletionList ifEmpty: [ ^ aCompletionList ].
	self context ifNil: [ ^ aCompletionList ].
	prefix := self typedPrefix.
	prefix isEmpty ifTrue: [ ^ aCompletionList ].

	^ aCompletionList asSortedCollection: [ :a :b |
			  | distanceA distanceB labelA labelB |
			  labelA := self labelForEntry: a.
			  labelB := self labelForEntry: b.
			  distanceA := self levenshteinDistanceBetween: prefix and: labelA.
			  distanceB := self levenshteinDistanceBetween: prefix and: labelB.
			  distanceA = distanceB
				  ifTrue: [ labelA <= labelB ]
				  ifFalse: [ distanceA < distanceB ] ]
]

{ #category : 'sorting' }
LevenshteinSorter >> typedPrefix [
	"Extract the word immediately before the caret from the current completion context."

	| textUpToCaret tokens |
	self context ifNil: [ ^ '' ].

	(self context respondsTo: #currentWord) ifTrue: [ ^ (self context perform: #currentWord) asString ].

	((self context respondsTo: #source) and: [ self context respondsTo: #position ]) ifFalse: [ ^ '' ].

	textUpToCaret := (self context perform: #source) copyFrom: 1 to: (self context perform: #position).
	tokens := textUpToCaret trimRight findTokens: Character separators.

	^ tokens ifEmpty: [ '' ] ifNotEmpty: [ tokens last asString ]
]
