package org.ohdsi.webapi.versioning.converter;

import org.ohdsi.webapi.converter.BaseConversionServiceAwareConverter;
import org.ohdsi.webapi.user.dto.UserDTO;
import org.ohdsi.webapi.versioning.domain.VersionBase;
import org.ohdsi.webapi.versioning.dto.VersionDTO;
import org.springframework.stereotype.Component;

@Component
public class VersionBaseToVersionDTOConverter extends BaseConversionServiceAwareConverter<VersionBase, VersionDTO> {
    @Override
    public VersionDTO convert(VersionBase source) {
        VersionDTO target = new VersionDTO();

        target.setComment(source.getComment());
        target.setAssetId(source.getAssetId());
        target.setId(source.getId());
        target.setVersion(source.getVersion());
        target.setArchived(source.isArchived());
        target.setCreatedBy(conversionService.convert(source.getCreatedBy(), UserDTO.class));
        target.setCreatedDate(source.getCreatedDate());

        return target;
    }
}
