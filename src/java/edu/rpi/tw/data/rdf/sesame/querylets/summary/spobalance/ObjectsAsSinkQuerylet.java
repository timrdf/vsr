package edu.rpi.tw.data.rdf.sesame.querylets.summary.spobalance;

import java.util.HashSet;
import java.util.Set;

import org.openrdf.model.Resource;
import org.openrdf.query.BindingSet;

import edu.rpi.tw.data.rdf.sesame.query.impl.DefaultQuerylet;
import edu.rpi.tw.data.rdf.sesame.query.returning.QueryletReturning;

/**
 * 
 */
public class ObjectsAsSinkQuerylet extends    DefaultQuerylet
								           implements QueryletReturning<Set<Resource>> {

	private HashSet<Resource> objectSinks;
	
	public ObjectsAsSinkQuerylet(Resource context) {
		super(context);
	}

	@Override
	public String getQueryString(Resource context) {
		
		objectSinks = new HashSet<Resource>();
		
        String select       = "distinct ?o";
        String graphPattern = "       [] ?p ?o . filter(!isLiteral(?o)) \n" +
                              "   optional {?o ?p1 ?s }     \n" +
                              "     filter (!bound(?s))";
        String orderBy = "";
        
        return composeQuery(select, context, graphPattern, orderBy);
	}

	@Override
	public void handleBindingSet(BindingSet bindings) {
		this.objectSinks.add((Resource)bindings.getValue("o"));
	}
	
	@Override
	public Set<Resource> get() {
		return objectSinks;
	}
}