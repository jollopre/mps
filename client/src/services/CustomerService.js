import { FetchWrapper } from './FetchWrapper';

export default class CustomerService {
    static index() {
        return FetchWrapper.get('/api/customers');
    }
}