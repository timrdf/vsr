package edu.rpi.tw.data.rdf.sesame.querylets.summary.spobalance;

import java.util.Collection;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Set;

import org.openrdf.model.Literal;
import org.openrdf.model.Resource;
import org.openrdf.model.URI;
import org.openrdf.query.BindingSet;

import edu.rpi.tw.data.rdf.sesame.query.IterableQuerylet;
import edu.rpi.tw.data.rdf.sesame.query.impl.DefaultQuerylet;
import edu.rpi.tw.data.rdf.sesame.query.impl.PluralContextsQuerylet;

/**
 * 
 */
public class ObjectLiteralsDistributionQuerylet extends    PluralContextsQuerylet<HashMap<URI,HashMap<String,Integer>>>
                				    	               implements IterableQuerylet<HashMap<URI,HashMap<String,Integer>>> {

	private Iterator<Resource> predicates = null;
	private Resource           predicate  = null;
	
	private HashMap<URI,HashMap<String,Integer>> distribution = null;
	
	/**
	 * 
	 * @param context
	 * @param predicates used to spread out the number of queries (one per predicate).
	 */
	public ObjectLiteralsDistributionQuerylet(Resource context, Set<Resource> predicates) {
		super(context);
		this.predicates   = predicates.iterator();
		this.distribution = new HashMap<URI,HashMap<String,Integer>>();
	}

	// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 
	@Override
	public boolean hasNext() {
		return predicates != null && predicates.hasNext();
	}
	
	@Override
	public void advance() {
		predicate = predicates.next();
	}

	@Override
	public String getType() {
		return predicate.stringValue();
	}
	// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 


	@Override
	public String getQueryString(Collection<Resource> contexts) {
		String p = "<"+predicate.stringValue()+">";
		
        String select       = "?o";
        String graphPattern = "[] "+p+" ?o . filter (isLiteral(?o))";
        String orderBy = "";
        
        return composeQuery(select, contexts, graphPattern, orderBy);
	}

	@Override
	public void handleBindingSet(BindingSet bindings) {
		Literal object  = (Literal) bindings.getValue("o");
		String  objectS = object.stringValue();
		
		URI datatype = object.getDatatype();
		
		if( !distribution.containsKey(datatype) ) {
			distribution.put(datatype, new HashMap<String,Integer>());
		}
		if( !distribution.get(datatype).containsKey(objectS) ) {
			distribution.get(datatype).put(objectS, 1);
		}else {
			distribution.get(datatype).put(objectS, 1 + distribution.get(datatype).get(objectS));
		}
	}

	@Override
	public HashMap<URI,HashMap<String,Integer>> get() {
		return distribution;
	}
}