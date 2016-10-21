package species.trait;

import species.TaxonomyDefinition;
import species.Field;
import species.UtilsService;
import species.Resource;
import species.Resource.ResourceType;
import species.utils.ImageType;
import species.utils.ImageUtils;

class TraitValue {

    Trait trait;
    String value;
    String description;
    String icon;
    String source;
//    TaxonomyDefinition taxon;
	
    def grailsApplication;

    static constraints = {
        trait nullable:false, blank:false, unique:['value']
        value nullable:false
		description nullable:true
        icon nullable:true
        source nullable:false
        //taxon nullable:false
    }

    static mapping = {
        description type:"text"
        id  generator:'org.hibernate.id.enhanced.SequenceStyleGenerator', params:[sequence_name: "trait_value_id_seq"] 
    }

	Resource icon(ImageType type) {
		boolean iconPresent = (new File(grailsApplication.config.speciesPortal.traits.rootDir.toString()+this.icon)).exists()
		if(!iconPresent) {
            log.warn "Couldn't find logo at "+grailsApplication.config.speciesPortal.traits.rootDir.toString()+this.icon
			return new Resource(fileName:grailsApplication.config.speciesPortal.resources.serverURL.toString()+"/no-image.jpg", type:ResourceType.ICON, title:"");
		}
		return new Resource(fileName:grailsApplication.config.speciesPortal.traits.serverURL+this.icon, type:ResourceType.ICON, title:this.value);
	}

	Resource mainImage() {
		return icon(ImageType.NORMAL);
	}
}
