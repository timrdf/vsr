package edu.rpi.tw.data.rdf.sesame.querylets.summary.spobalance;

import java.util.HashSet;
import java.util.Set;

import org.openrdf.model.Resource;
import org.openrdf.query.BindingSet;

import edu.rpi.tw.data.rdf.sesame.query.impl.DefaultQuerylet;

/**
 * 
 */
public class SubjectsAsSourceQuerylet extends DefaultQuerylet<Set<Resource>> {
							//		  implements QueryletReturning<Set<Resource>> {
	
	private HashSet<Resource> sourceSubjects;
	
	public SubjectsAsSourceQuerylet(Resource context) {
		super(context);
	}

	@Override
	public String getQueryString(Resource context) {
		
		sourceSubjects = new HashSet<Resource>();
		
        String select       = "distinct ?s";
        String graphPattern = "                        ?s ?p [] .\n" +
                              "      optional {?s1 ?p1 ?s .}     \n" +
                              " filter (!bound(?s1))";
        String orderBy = "";
        
        return composeQuery(select, context, graphPattern, orderBy);
	}

	@Override
	public void handleBindingSet(BindingSet bindings) {
		this.sourceSubjects.add((Resource)bindings.getValue("s"));
	}

	@Override
	public Set<Resource> get() {
		return sourceSubjects;
	}
}