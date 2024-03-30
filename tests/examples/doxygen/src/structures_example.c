/*The purpose of this file is adding a structures section to doxygen
 * so we can test.*/

#ifndef _TRIANGLE_PROTOTYPES_DOXYGEN_H
#  define _TRIANGLE_PROTOTYPES_DOXYGEN_H

#  include <systemheader1.h>
#  include <systemheader2.h>

#  include <triangle/header1.h>
#  include <triangle/header2.h>

#  include "local_triangle_header1.h"
#  include "local_triangle_header2.h"

/**
 * @brief Enumeration for triangle types.
 *
 * Detailed explanation about different types of triangles.
 */
typedef enum TriangleEnum_enum {
  TRIANGLE_FIRST,  /**< Some documentation for the first type. */
  TRIANGLE_SECOND, /**< Some documentation for the second type. */
  TRIANGLE_ETC     /**< Etc. */
} TriangleEnum;

/**
 * @brief Structure representing a triangle.
 *
 * Detailed explanation about the members of the TriangleStruct.
 */
typedef struct TriangleStruct_struct {
  int side1;    /**< Length of the first side. */
  int side2;    /**< Length of the second side. */
  double angle; /**< Angle between the sides. */
} TriangleStruct;

/**
 * @brief Function to calculate properties of a triangle.
 *
 * Calculates and returns information about the triangle based on given parameters.
 * @param side1 Length of the first side.
 * @param side2 Length of the second side.
 * @param angle Angle between the sides.
 * @return A structure containing properties of the triangle.
 * @see Triangle_The_Second_Function
 * @see Triangle_The_Last_One
 * @see http://trianglewebsite/
 * @note Something to note about triangle calculations.
 * @warning Warning related to triangle calculations.
 */
TRIANGLEEXPORT TriangleStruct *
Triangle_The_Function_Name(int side1, int side2, double angle /*, ...*/);

/**
 * @brief A simple stub function for triangle documentation.
 *
 * Demonstrates how links work in the documentation for triangles.
 * @return @c NULL is always returned.
 */
TRIANGLEEXPORT void *
Triangle_The_Second_Function(void);

/**
 * Function without a brief explanation for triangle documentation.
 * If Doxygen is configured with JAVADOC_AUTOBRIEF=YES, then the first line of
 * the comment is used as a brief explanation.
 */
TRIANGLEEXPORT void
Triangle_The_Last_One(void);

#endif /* _TRIANGLE_PROTOTYPES_DOXYGEN_H */

