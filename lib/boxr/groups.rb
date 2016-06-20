module Boxr
  class Client
    def groups(fields: [])
      query = build_fields_query(fields, GROUP_FIELDS_QUERY)
      get_all_with_pagination(GROUPS_URI, query: query, offset: 0, limit: DEFAULT_LIMIT)
    end

    def create_group(name)
      attributes = { name: name }
      new_group, _response = post(GROUPS_URI, attributes)
      new_group
    end

    def update_group(group, name)
      group_id = ensure_id(group)
      uri = "#{GROUPS_URI}/#{group_id}"
      attributes = { name: name }

      updated_group, _response = put(uri, attributes)
      updated_group
    end
    alias rename_group update_group

    def delete_group(group)
      group_id = ensure_id(group)
      uri = "#{GROUPS_URI}/#{group_id}"
      result, _response = delete(uri)
      result
    end

    def group_memberships(group)
      group_id = ensure_id(group)
      uri = "#{GROUPS_URI}/#{group_id}/memberships"
      get_all_with_pagination(uri, offset: 0, limit: DEFAULT_LIMIT)
    end

    def group_memberships_for_user(user)
      user_id = ensure_id(user)
      uri = "#{USERS_URI}/#{user_id}/memberships"
      get_all_with_pagination(uri, offset: 0, limit: DEFAULT_LIMIT)
    end

    def group_memberships_for_me
      uri = "#{USERS_URI}/me/memberships"
      get_all_with_pagination(uri, offset: 0, limit: DEFAULT_LIMIT)
    end

    def group_membership_from_id(membership_id)
      membership_id = ensure_id(membership_id)
      uri = "#{GROUP_MEMBERSHIPS_URI}/#{membership_id}"
      membership, _response = get(uri)
      membership
    end
    alias group_membership group_membership_from_id

    def add_user_to_group(user, group, role: nil)
      user_id = ensure_id(user)
      group_id = ensure_id(group)

      attributes = { user: { id: user_id }, group: { id: group_id } }
      attributes[:role] = role unless role.nil?
      membership, _response = post(GROUP_MEMBERSHIPS_URI, attributes)
      membership
    end

    def update_group_membership(membership, role)
      membership_id = ensure_id(membership)
      uri = "#{GROUP_MEMBERSHIPS_URI}/#{membership_id}"
      attributes = { role: role }
      updated_membership, _response = put(uri, attributes)
      updated_membership
    end

    def delete_group_membership(membership)
      membership_id = ensure_id(membership)
      uri = "#{GROUP_MEMBERSHIPS_URI}/#{membership_id}"
      result, _response = delete(uri)
      result
    end

    def group_collaborations(group)
      group_id = ensure_id(group)
      uri = "#{GROUPS_URI}/#{group_id}/collaborations"
      get_all_with_pagination(uri, offset: 0, limit: DEFAULT_LIMIT)
    end
  end
end
