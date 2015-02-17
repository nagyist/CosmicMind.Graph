/**
* Copyright (C) 2015 GraphKit, Inc. <http://graphkit.io> and other GraphKit contributors.
*
* This program is free software: you can redistribute it and/or modify
* it under the terms of the GNU Affero General Public License as published
* by the Free Software Foundation, either version 3 of the License, or
* (at your option) any later version.
*
* This program is distributed in the hope that it will be useful,
* but WITHOUT ANY WARRANTY; without even the implied warranty of
* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
* GNU Affero General Public License for more details.
*
* You should have received a copy of the GNU Affero General Public License
* along with this program located at the root of the software package
* in a file called LICENSE.  If not, see <http://www.gnu.org/licenses/>.
*
* GKEntity
*
* Represents Entity Nodes, which are person, places, or things -- nouns.
*/

import Foundation

@objc(GKEntity)
public class GKEntity : GKNode {

    /**
    * init
    * Initializes GKEntity with a given type.
    * @param        type: String!
    */
    override public init(type: String) {
        super.init(type: type)
    }

    /**
    * actions
    * Retrieves an Array of GKAction Objects.
    * @return       Array<GKAction>
    */
    public var actions: Array<GKAction> {
        get {
            return actionsAsSubject + actionsAsObject
        }
        set(value) {
            assert(false, "[GraphKit Error: Actions may not be set.]")
        }
    }

    /**
    * actionsAsSubject
    * Retrieves an Array of GKAction Objects when the Entity is a Subject of the Action.
    * @return       Array<GKAction>
    */
    public var actionsAsSubject: Array<GKAction> {
        get {
            var nodes: Array<GKAction> = Array<GKAction>()
            graph.managedObjectContext.performBlockAndWait {
                var node: GKManagedEntity = self.node as GKManagedEntity
                for item: AnyObject in node.actionSubjectSet {
                    nodes.append(GKAction(action: item as GKManagedAction))
                }
            }
            return nodes
        }
        set(value) {
            assert(false, "[GraphKit Error: Actions may not be set.]")
        }
    }

    /**
    * actionsAsObject
    * Retrieves an Array of GKAction Objects when the Entity is an Object of the Action.
    * @return       Array<GKAction>
    */
    public var actionsAsObject: Array<GKAction> {
        get {
            var nodes: Array<GKAction> = Array<GKAction>()
            graph.managedObjectContext.performBlockAndWait {
                var node: GKManagedEntity = self.node as GKManagedEntity
                for item: AnyObject in node.actionObjectSet {
                    nodes.append(GKAction(action: item as GKManagedAction))
                }
            }
            return nodes
        }
        set(value) {
            assert(false, "[GraphKit Error: Actions may not be set.]")
        }
    }

    /**
    * init
    * Initializes GKEntity with a given GKManagedEntity.
    * @param        entity: GKManagedEntity!
    */
    internal init(entity: GKManagedEntity!) {
        super.init(node: entity)
    }

    /**
    * createImplementorWithType
    * Initializes GKManagedEntity with a given type.
    * @param        type: String!
    * @return       GKManagedEntity
    */
    override internal func createImplementorWithType(type: String) -> GKManagedNode {
        return GKManagedEntity(type: type);
    }
}
