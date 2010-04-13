cdef extern from "plist/plist.h":
    ctypedef void *plist_t
    ctypedef void *plist_dict_iter
    void plist_free(plist_t node)

cdef class Node:
    cdef plist_t _c_node
    cdef bool _c_managed
    cpdef object __deepcopy__(self, memo=*)
    cpdef unicode to_xml(self)
    cpdef bytes to_bin(self)
    cpdef object copy(self)

cdef class Bool(Node):
    cpdef set_value(self, object value)
    cpdef bool get_value(self)
    
cdef class Integer(Node):
    cpdef set_value(self, object value)
    cpdef int get_value(self)

cdef class Real(Node):
    cpdef set_value(self, object value)
    cpdef float get_value(self)

cdef class String(Node):
    cpdef set_value(self, unicode value)
    cpdef unicode get_value(self)

cdef class Date(Node):
    cpdef set_value(self, value)
    cpdef object get_value(self)

cdef class Data(Node):
    cpdef set_value(self, bytes value)
    cpdef bytes get_value(self)

cdef class Dict(Node):
    cdef dict _map
    cdef void _init(self)
    cpdef set_value(self, dict value)
    cpdef dict get_value(self)
    cpdef bool has_key(self, key)
    cpdef object get(self, key, default=*)
    cpdef list keys(self)
    cpdef list items(self)
    cpdef list values(self)
    cpdef object iterkeys(self)
    cpdef object iteritems(self)
    cpdef object itervalues(self)

cdef class Array(Node):
    cdef list _array
    cdef void _init(self)
    cpdef set_value(self, value)
    cpdef list get_value(self)
    cpdef append(self, item)

cpdef object from_xml(xml)
cpdef object from_bin(bytes bin)

cdef object plist_t_to_node(plist_t c_plist, bool managed=*)
cdef plist_t native_to_plist_t(object native)
