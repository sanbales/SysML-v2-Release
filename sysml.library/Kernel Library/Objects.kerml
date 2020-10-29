/**
 * This package defines classifiers and features that related to the typing of objects and links.
 */
package Objects {
	private import Base::Anything;
	private import Base::things;
	private import Occurrences::Occurrence;
	private import Performances::Performance;
	
	/**
	 * Object is the most general classifier of non-behavioral occurrences that may change over time.
	 */
	abstract class Object specializes Occurrence {
		feature self: Object redefines Occurrence::self;
		
		/**
		 * Performances in which this object is involved.
		 */
		feature involvingPerformances: Performance[0..*];
		
		/**
		 * Performances which are enacted by this object.
		 */
		abstract feature enactedPerformances: Performance[0..*] subsets involvingPerformances, suboccurrences;
	}
	
	/**
	 * Link is the most general association between two or more things.
	 * (It is actually class, not an association, because an association
	 * must have a specific number of ends.)
	 */
	class Link specializes Object {
		feature participant: Anything[2..*] nonunique ordered;
	}
	
	/**
	 * BinaryLink is the most general binary association between exactly two things, 
	 * nominally directed from source to target.
	 */
	assoc BinaryLink specializes Link {
	    feature participant: Anything[2] nonunique ordered redefines Link::participant;
		
		end feature source: Anything[0..*] nonunique subsets participant;
	    end feature target: Anything[0..*] nonunique subsets participant;
	    
// Means:
//	    feature sourceParticipant: Anything[1] subsets participant {
//	    	feature targetEnd: Anything[0..*] = BinaryLink::targetParticipant(sourceParticipant);
//	    }
//	    feature targetParticipant: Anything[1] subsets participant {
//	    	feature sourceEnd: Anything[0..*] = BinaryLink::sourceParticipant(targetParticipant);
//	    }  

// Was:
//	    feature sourceParticipant: Anything[1..1] subsets participant = participant[1];
//	    feature targetParticipant: Anything[1..1] subsets participant = participant[2];
//	
//	    private connector linkage: BinaryLink is sourceParticipant to targetParticipant;	
	}
	
	/**
	 * SelfLink is a binary association in which the individuals at the two ends are asserted
	 * to be the same.
	 */
	assoc SelfLink specializes BinaryLink {
		end feature self: Anything[0..*] nonunique redefines source subsets myself redefines Anything::self;
		end feature myself: Anything[0..*] nonunique redefines target subsets self;
		
//		feature sourceParticipant: Anything[1..1] redefines BinaryLink::sourceParticipant subsets targetParticipant; 
//		feature targetParticipant: Anything[1..1] redefines BinaryLink::targetParticipant subsets sourceParticipant;
	}
		
	/**
	 * objects is a specialization of things restricted to type Object.
	 */
	abstract feature objects: Object[0..*] nonunique subsets things;
	
	/**
	 * links is the most general feature of links between individuals.
	 */
	abstract feature links: Link[0..*] nonunique subsets objects;
	
	/**
	 * binaryLinks is a specialization of links restricted to type BinaryLink.
	 */
	abstract feature binaryLinks: BinaryLink[0..*] nonunique subsets links {
		end feature source: Anything[0..*] nonunique redefines BinaryLink::source;
		end feature target: Anything[0..*] nonunique redefines BinaryLink::target;
	}
	
	/**
	 * selfLinks is a specialization of binaryLinks restricted to type SelfLink.
	 */
	abstract feature selfLinks: SelfLink[0..*] nonunique subsets binaryLinks {
		end feature source: Anything[0..*] nonunique redefines SelfLink::self, binaryLinks::source;
		end feature target: Anything[0..*] nonunique redefines SelfLink::myself, binaryLinks::target;
	}
	
}