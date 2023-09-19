Extension { #name : 'SequenceableCollection' }

{ #category : '*Wolfram' }
SequenceableCollection >> putOnLink: link [

	^ (link head: 'List' arguments: self) putOnLink: link
]
