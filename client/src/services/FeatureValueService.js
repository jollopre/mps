import { FetchWrapper } from './FetchWrapper';

export default class FeatureValueService {
	static update(id, value) {
		return FetchWrapper.put(`/api/feature_values/${id}`,
			{feature_value: { value: value }});
	}
}