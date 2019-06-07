/* SPDX-License-Identifier: GPL-2.0 */
#include <stdlib.h>

struct node {
	long		data;
	struct node	*next;
	struct node	*prev;
};

static struct node *insert(struct node *head, long data)
{
	struct node *n = malloc(sizeof(struct node));
	if (!n)
		return NULL;
	n->data = data;
	n->next = head->next;
	n->prev = head;
	head->next->prev = n;
	head->next = n;
	return head;
}

int main(void)
{
	struct node head = {.data = 0, .next = &head, .prev = &head};
	struct node *n;
	long data[] = {1, 2, 3, 4, 5, 6, 7, 8, 9, 10};
	int i;

	for (i = sizeof(data)/sizeof(data[0])-1; i >= 0; i--)
		if (!insert(&head, data[i]))
			return EXIT_FAILURE;
	/* test the list */
	for (n = head.next, i = 0; n != &head; n = n->next, i++)
		if (n->data != data[i])
			return EXIT_FAILURE;
	if (i != 10)
		return EXIT_FAILURE;
	return EXIT_SUCCESS;
}
