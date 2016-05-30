package edu.rpi.tw.data.rdf.sesame.querylets.summary;

import java.util.Collection;

import org.openrdf.model.Resource;
import org.openrdf.query.BindingSet;
import org.openrdf.query.QueryLanguage;

import edu.rpi.tw.data.rdf.sesame.query.IterableQuerylet;

/**
 * @deprecated use Names.java
 * 
 */
public class NamesAndValues implements IterableQuerylet {

   Resource context;

   public NamesAndValues(Resource context) {
      this.context = context;
   }

   public String getQueryString() {
      return getQueryString(this.context);
   }

   public String getQueryString(Resource context) {
      return null;
   }

   public QueryLanguage getQueryLanguage() {
      return QueryLanguage.SPARQL;
   }

   public boolean hasNext() {
      return false;
   }

   public void advance() {
   }

   public String getType() {
      return null;
   }

   public void handleBindingSet(BindingSet bindingSet) {
   }

   public void finish(int numResults) {
      // balanceArray.add(numResults);
   }

   @Override
   public Object get() {
      return null;
   }

   @Override
   public String getQueryString(Collection contexts) {
      return null;
   }
}