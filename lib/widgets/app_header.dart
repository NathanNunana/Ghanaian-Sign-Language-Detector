part of bc_widgets;

class CustomAppHeader extends ConsumerWidget {
  final double? height;
  final String? title;
  const CustomAppHeader({super.key, this.height, this.title});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appTheme = AppTheme.appTheme(context);
    final textTheme = CustomTextTheme.customTextTheme(context).textTheme;
    return Container(
      height: height,
      padding: const EdgeInsets.symmetric(
        vertical: 18,
        horizontal: 15,
      ),
      decoration: BoxDecoration(
        color: appTheme.primaryColor,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const ListTile(
            contentPadding: EdgeInsets.zero,
            // leading: ,
          ),
          const SizedBox(
            height: 5,
          ),
          Center(
            child: SizedBox(
              // width: MediaQuery.of(context).size.width / 2,
              child: Text(
                title ?? "",
                style: textTheme.labelLarge,
                maxLines: 2,
              ),
            ),
          ),
          const SizedBox(
            height: 29,
          ),
        ],
      ),
    );
  }
}
