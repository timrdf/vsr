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
public class SubjectsAsBridgeQuerylet extends DefaultQuerylet<Set<Resource>> {
                                   //   implements QueryletReturning<> {

	private HashSet<Resource> bridgeSubjects;
	
	public SubjectsAsBridgeQuerylet(Resource context) {
		super(context);
	}

	@Override
	public String getQueryString(Resource context) {
		
		bridgeSubjects = new HashSet<Resource>();
		
        String select       = "distinct ?s";
        String graphPattern = 
             "                 ?s ?p [] .\n" +
             "          [] ?p1 ?s . \n" +
             " filter        (!bound(?o))"; // TODO: irrelevant
        String orderBy = "";
        
		return composeQuery(select, context, graphPattern, orderBy);
	}

	@Override
	public void handleBindingSet(BindingSet bindings) {
		this.bridgeSubjects.add((Resource)bindings.getValue("s"));
	}

	@Override
	public Set<Resource> get() {
		return bridgeSubjects;
	}
}